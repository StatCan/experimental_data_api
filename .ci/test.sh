function unit_test() {
  registry_login

  docker-compose -f docker-compose.test.yml up --build --exit-code-from test
}
