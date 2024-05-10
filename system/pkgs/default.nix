{ foundry, forester, ... } : {
  environment.systemPackages = [
    forester.packages.x86_64-linux.default
    foundry.defaultPackage.x86_64-linux
  ];
}
