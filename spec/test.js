import { Selector, Role } from 'testcafe'

const user = Role('http://localhost:3000/users/sign_in', async (t) => {
  await t
    .typeText('#user_email', process.env.USER_EMAIL)
    .typeText('#user_password', process.env.USER_PASSWORD)
    .click('input[value="Inloggen"]')
}, { preserveUrl: true })

fixture`Nutrients`
  .beforeEach(t => t.useRole(user).navigateTo('http://localhost:3000/nutrients'))

test('Nutrients', async t => {
  await t.expect(Selector('h1').withText('Listing nutrients').exists).ok()
})