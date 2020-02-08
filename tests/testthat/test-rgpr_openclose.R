test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("connect to db",{
  expect_true(
    DBI::dbIsValid(RGP_open_conn())
    )
})

test_that("download gym_info",{
  expect_silent(RGP_get_gyms(RGP_open_conn()))
})
