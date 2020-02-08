test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("connect to db",{
  expect_true(
    DBI::dbIsValid(open_RGP_conn())
    )
})
