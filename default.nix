let

    # ihp = builtins.fetchGit {
    #     url = "https://github.com/digitallyinduced/ihp.git";
    #     ref = "refs/tags/v0.12.0";
    # };

    ihp = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/ihp.git";
        rev = "ea6bcf73c93dd5a1f3440e39c877ec7da16dc43b";
        ref = "*";
    };

    haskellEnv = import "${ihp}/NixSupport/default.nix" {
        ihp = ihp;
        haskellDeps = p: with p; [
            cabal-install
            base
            wai
            text
            hlint
            p.ihp
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv
