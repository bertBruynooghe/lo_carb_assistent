import { Selector, Role } from 'testcafe'

const user = Role('http://localhost:3000/users/sign_in', async (t) => {
  await t
    .typeText('#user_email', process.env.USER_EMAIL)
    .typeText('#user_password', process.env.USER_PASSWORD)
    .click('input[value="Inloggen"]')
}, { preserveUrl: true })

fixture`Nutrients`
  .beforeEach(t => t.useRole(user).navigateTo('http://localhost:3000/nutrients'))

const nutrientName1 = 'nutrient_' + new Date().toISOString()
const nutrientName2 = 'nutrient_' + new Date().toISOString()

const valueRow1 = Selector('td').withText(nutrientName1)
    .nextSibling(0).withText('1.2')
    .nextSibling(0).withText('3.4')
    .nextSibling(0).withText('5.6')
    .nextSibling(0).withText('7.8')

const valueRow2 = Selector('td').withText(nutrientName2)
    .nextSibling(0).withText('8.7')
    .nextSibling(0).withText('6.5')
    .nextSibling(0).withText('4.3')
    .nextSibling(0).withText('2.1')

function fillNutrientForm (...args) {
  const t =
    this.selectText('input#nutrient_name')
        .typeText('input#nutrient_name', args[0])
  return ['calories', 'carbs', 'proteins', 'fat'].reduce((acc, name, i) =>
      acc.selectText(`input#nutrient_${name}_integral`)
         .typeText(`input#nutrient_${name}_integral`, '' + args[i*2+1])
         .selectText(`input#nutrient_${name}_fractional`)
         .typeText(`input#nutrient_${name}_fractional`, '' + args[i*2+2])
  , t).click('input[value="Save"]')
}

test('Nutrients', async t => {
  await t.expect(Selector('h1').withText('Listing nutrients').exists).ok()

    .click(Selector('a').withText('New Nutrient'))
    .expect(Selector('h1').withText('New nutrient').exists).ok()

  await fillNutrientForm.call(t, nutrientName1, 1, 2, 3, 4, 5, 6, 7, 8)

    .expect(Selector('h1').withText('Listing nutrients').exists).ok()
    .expect(valueRow1.exists).ok()

    .click(valueRow1.nextSibling(1).find('a').withText('Edit'))
    .expect(Selector('h1').withText('Editing nutrient').exists).ok()
    .expect(Selector(`input#nutrient_name[value="${nutrientName1}"]`).exists).ok()
    .expect(Selector('input#nutrient_calories_integral[value="1"]').exists).ok()
    .expect(Selector('input#nutrient_calories_fractional[value="2"]').exists).ok()
    .expect(Selector('input#nutrient_carbs_integral[value="3"]').exists).ok()
    .expect(Selector('input#nutrient_carbs_fractional[value="4"]').exists).ok()
    .expect(Selector('input#nutrient_proteins_integral[value="5"]').exists).ok()
    .expect(Selector('input#nutrient_proteins_fractional[value="6"]').exists).ok()
    .expect(Selector('input#nutrient_fat_integral[value="7"]').exists).ok()
    .expect(Selector('input#nutrient_fat_fractional[value="8"]').exists).ok()
  
  await fillNutrientForm.call(t, nutrientName2, 8, 7, 6, 5, 4, 3, 2, 1)
    .expect(Selector('p#notice').withText('Nutrient was successfully updated.').exists).ok()
    // TODO: check the show page
    .click(Selector('a').withText('Back'))
    // .debug()
    .expect(Selector('h1').withText('Listing nutrients').exists).ok()
    .expect(valueRow2.exists).ok()

    // TODO: delete the row...
})