# Negative test for check-safe.ps1.
#
# check-safe.ps1 is the control that stops this repository publishing anything identifying the live
# system it describes. A control nobody has tried to defeat is not a control, it is a habit. So
# this plants one known-bad string at a time in a scratch copy and asserts the scanner refuses it -
# and asserts the clean copy passes, because a scanner that failed everything would also "catch"
# all of these while being useless.
#
#   py check-safe-negative-test.py          (from qa-cartographer\tests\)
#
# Exit 0 = the clean copy passes and every planted identifier is caught.
#
# WHY THE FIXTURES ARE ASSEMBLED AT RUNTIME. Every string below is exactly what must never ship, so
# writing them as literals would make this file fail the scan it exists to verify. The obvious fix
# is to add this file to the scanner's exclusion list - and that is the wrong fix. The exclusion
# list is a hole, check-safe.ps1 already documents the one hole it cannot avoid (it contains the
# patterns it searches for), and a security control should not grow a second exception because a
# test was inconvenient. So the tokens are split across a join and never appear whole in the
# source. Slightly awkward to read; keeps the exclusion list at exactly one file.

import io, os, shutil, stat, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.dirname(HERE)
WORK = os.path.join(tempfile.gettempdir(), "check-safe-negtest")
TARGET = "reference/walk-order.md"        # any shipped file; content is irrelevant to the scan

J = "".join

# Each is a real class of thing that has already appeared in this repository's drafts.
PLANTS = [
    ("email address",        "Sign in as " + J(["tester.one", "@example", ".com"]) + " before recording."),
    ("account identifier",   "The accounts are " + J(["mb", "-qa01@"]) + " and " + J(["mb", "-qa02@"]) + "."),
    ("owner address",        "Do not use " + J(["mb", "@"]) + " for entitlement work."),
    ("product name",         "The territory is the " + J(["Urban", " Pulse"]) + " production QA engagement."),
    ("product, hyphenated",  "See " + J(["Urban", "-Pulse"]) + "-QA-Test-Suite.xlsx for the cases."),
    ("mail domain",          "Every alias resolves under the " + J([".", "com", ".", "au"]) + " tenant."),
    ("mail provider",        "The aliases are " + J(["M", "365"]) + " aliases with no login of their own."),
    ("payment provider",     "Written only by the signature-verified " + J(["Str", "ipe"]) + " webhook."),
    ("repository name",      "The territory lives in " + J(["Genesis", "Matrix"]) + " and syncs upstream."),
    ("repository URL",       "Fixed in " + J(["github", ".com/", "example-org/example-repo"]) + "."),
    ("third party's name",   "That fix never reached the sheet " + J(["G", "uy"]) + " signs off."),
    ("pull request number",  "Fixed in " + J(["PR", " #1093"]) + " across eight sites."),
    ("internal symbol",      J(["grant_org", "_entitlement"]) + "() exists and nothing calls it."),
    ("SQL privilege model",  "It is a " + J(["SECURITY", " DEFINER"]) + " function, so it runs as the owner."),
    ("case ID prefix",       "P14 holds " + J(["UP", "-ENT-001"]) + " to " + J(["UP", "-ENT-009"]) + "."),
    ("session GUID",         "See [INDEX](" + J(["vscode-", "webview://", "1or0dl615kchhf791p2393lijol"]) + "/x)."),
    ("audit finding",        "The grant is one-way: the audit reports it " + J(["cannot be", " revoked"]) + "."),
    ("auth mechanism",       J(["SSO", " resolves"]) + " to the " + J(["primary identity", " behind"]) + " the alias."),
    ("admin route",          "The cases prove " + J(["/", "admin"]) + " is invisible to a non-admin."),
    ("account purge logic",  "The " + J(["staff", "-domain"]) + " check runs before the plus-tag rule."),
]


def _force_remove(func, path, exc):
    """Git objects are read-only; a plain rmtree leaves them and the next run cannot start."""
    os.chmod(path, stat.S_IWRITE)
    func(path)


def _clean(path):
    if os.path.isdir(path):
        shutil.rmtree(path, onexc=_force_remove)

def reset():
    # .git is skipped deliberately: it is not shipped content, it holds read-only object files that
    # break a plain copy, and its config carries the remote URL - which the scanner would correctly
    # flag as a repository identifier. Ignoring it here is not a loophole; check-safe.ps1 skips it
    # too, for the same reason.
    _clean(WORK)
    shutil.copytree(SRC, WORK, ignore=shutil.ignore_patterns(".git"))


def run():
    p = subprocess.run(
        ["powershell", "-ExecutionPolicy", "Bypass", "-File",
         os.path.join(WORK, "check-safe.ps1"), "-Root", WORK, "-Quiet"],
        capture_output=True, text=True)
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def main():
    reset()
    rc, out = run()
    print("clean copy: exit %d  %s" % (rc, "pass" if rc == 0 else "FAIL <-- unexpected"))
    if rc != 0:
        print(out)
        return 1
    print()

    missed = 0
    for name, text in PLANTS:
        reset()
        f = os.path.join(WORK, TARGET.replace("/", os.sep))
        with io.open(f, "a", encoding="utf-8", newline="") as fh:
            fh.write("\n" + text + "\n")

        rc, out = run()
        if rc == 0:
            missed += 1
            print("  MISSED!  %-22s %s" % (name, text[:56]))
            continue
        rule = ""
        for ln in out.splitlines():
            if ln.startswith(("BLOCK", "REVIEW")) and "[" in ln and "]" in ln:
                rule = ln[ln.index("[") + 1:ln.index("]")]
                break
        print("  caught   %-22s [%s]" % (name, rule))

    _clean(WORK)
    print()
    print("%d/%d planted identifiers caught." % (len(PLANTS) - missed, len(PLANTS)))
    return 1 if missed else 0


if __name__ == "__main__":
    sys.exit(main())
