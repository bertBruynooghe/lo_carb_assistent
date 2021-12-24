import { Selector } from 'testcafe'

fixture`Getting Started`
  .page`http://localhost:3000/`

test('Login test', async t => {
    await t
      .typeText('#user_email', process.env.USER_EMAIL)
      .typeText('#user_password', process.env.USER_PASSWORD)
      .click('input[value="Inloggen"]')

    const notice  = await Selector('p[class="notice"]')
    
    await t.expect(notice.innerText).contains('Je bent succesvol ingelogd')
})