test_that("the package has its configured name", {
  expect_identical(utils::packageName(), "{{cookiecutter.package_name}}")
})
