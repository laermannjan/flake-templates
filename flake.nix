{
  description = ''
   This file is only here, so the template option of `nix flake new` works!
  '';
  outputs = {self}: {
    templates = {
      python-pipenv = {
        path = ./python-pipenv;
      };
    };
    defaultTemplate = self.templates.python;
  };
}
