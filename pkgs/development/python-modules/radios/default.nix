{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, poetry-core
, aiodns
, aiohttp
, awesomeversion
, backoff
, cachetools
, pycountry
, pydantic
, yarl
, pytest-asyncio
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "radios";
  version = "0.1.0";

  disabled = pythonOlder "3.9";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "frenck";
    repo = "python-radios";
    rev = "v${version}";
    hash = "sha256-3xRtOGY9DYnZN0g95213vWDbO3/XZZ5+s7A9sqNmO/w=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace "0.0.0" "${version}" \
      --replace "--cov" ""
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiodns
    aiohttp
    awesomeversion
    backoff
    cachetools
    pycountry
    pydantic
    yarl
  ];

  checkInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [ "radios" ];

  meta = with lib; {
    description = "Asynchronous Python client for the Radio Browser API";
    homepage = "https://github.com/frenck/python-radios";
    license = licenses.mit;
    maintainers = with maintainers; [ dotlambda ];
  };
}
