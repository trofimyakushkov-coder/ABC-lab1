#!/bin/bash

mkdir claude_monet
mkdir claude_monet/owner_office
mkdir claude_monet/contracts
mkdir claude_monet/advertising
mkdir claude_monet/kitchen
mkdir claude_monet/chef_office
mkdir claude_monet/hall
mkdir archive

echo "Дмитрий Нагиев требует подготовить ресторан к съёмке" > claude_monet/owner_office/owner_order
echo "Виктор Петрович должен представить новое меню" >> claude_monet/owner_office/owner_order
echo "Вика отвечает за порядок в зале" >> claude_monet/owner_office/owner_order

echo "Новая вывеска требует согласования" > claude_monet/owner_office/expense_plan
echo "Реклама ресторана оплачивается владельцем" >> claude_monet/owner_office/expense_plan
echo "Расходы на банкет проверить отдельно" >> claude_monet/owner_office/expense_plan

echo "Поставщик привозит продукты утром" > claude_monet/contracts/supplier_contract
echo "Шеф лично проверяет качество мяса" >> claude_monet/contracts/supplier_contract
echo "Оплата производится после приёмки" >> claude_monet/contracts/supplier_contract

echo "Музыканты выступают в пятницу вечером" > claude_monet/contracts/concert_contract
echo "Костя готовит напитки для артистов" >> claude_monet/contracts/concert_contract
echo "Вика согласует время начала программы" >> claude_monet/contracts/concert_contract

echo "Реклама показывает кухню и главный зал" > claude_monet/advertising/promo_plan
echo "Нагиев появляется в финале рекламного ролика" >> claude_monet/advertising/promo_plan
echo "Баринов отказывается повторять текст дважды" >> claude_monet/advertising/promo_plan

echo "Приготовить фирменное блюдо к восьми часам" > claude_monet/kitchen/chef_order
echo "Сеня и Федя отвечают за горячий цех" >> claude_monet/kitchen/chef_order
echo "Лёва проверяет выдачу каждого блюда" >> claude_monet/kitchen/chef_order

echo "Утиная ножка 850" > claude_monet/kitchen/menu_prices
echo "Луковый суп 430" >> claude_monet/kitchen/menu_prices
echo "Мильфей 520" >> claude_monet/kitchen/menu_prices
echo "Стейк от шефа 1100" >> claude_monet/kitchen/menu_prices

echo "Баринов согласен обновить меню" > claude_monet/chef_office/barinov_reply
echo "Баринов не согласен сниматься в рекламе" >> claude_monet/chef_office/barinov_reply
echo "Все решения по кухне принимает шеф" >> claude_monet/chef_office/barinov_reply

echo "За первым столом сидят актёры" > claude_monet/hall/vip_guests
echo "Для Нагиева оставить место у сцены" >> claude_monet/hall/vip_guests
echo "Постоянным гостям подать десерт от Луи" >> claude_monet/hall/vip_guests

echo "Нагиев позвонил Вике утром" > nagiev_call
echo "Владелец приедет после открытия" >> nagiev_call
echo "Отчёт о расходах должен быть готов" >> nagiev_call

chmod 755 claude_monet
chmod 750 claude_monet/owner_office
chmod 640 claude_monet/owner_office/owner_order
chmod 640 claude_monet/owner_office/expense_plan
chmod 750 claude_monet/contracts
chmod 640 claude_monet/contracts/supplier_contract
chmod 640 claude_monet/contracts/concert_contract
chmod 750 claude_monet/advertising
chmod 644 claude_monet/advertising/promo_plan
chmod 750 claude_monet/kitchen
chmod 640 claude_monet/kitchen/chef_order
chmod 644 claude_monet/kitchen/menu_prices
chmod 750 claude_monet/chef_office
chmod 640 claude_monet/chef_office/barinov_reply
chmod 755 claude_monet/hall
chmod 644 claude_monet/hall/vip_guests
chmod 750 archive
chmod 640 nagiev_call

cp nagiev_call claude_monet/owner_office/nagiev_call_copy
cp -r claude_monet/advertising claude_monet/owner_office/advertising_backup
ln -s claude_monet/contracts/supplier_contract owner_contract
ln -s ../hall claude_monet/owner_office/hall_access
ln claude_monet/contracts/supplier_contract claude_monet/contracts/supplier_duplicate
cat claude_monet/owner_office/owner_order claude_monet/chef_office/barinov_reply > claude_monet/owner_office/meeting_notes
cat claude_monet/kitchen/chef_order >> nagiev_call
mv claude_monet/advertising/promo_plan archive/promo_final

find . -type f ! -name '*copy*' -printf '%s %p\n' | sort -nr | head -5
grep -RhiE 'нагиев|баринов' claude_monet archive | grep -vi 'реклам' | sort -r | head -5
grep -Ril 'поставщик' claude_monet/contracts claude_monet/owner_office | wc -l
{ head -qn 1 claude_monet/contracts/*; tail -qn 1 claude_monet/contracts/*; } | grep -iE 'поставщик|музыкант|оплат' | sort
grep -vi 'согласен' claude_monet/owner_office/meeting_notes | grep -iE 'меню|кухн' | sort -r | wc -w
ls -lR | grep '^l' | sort -k9,9r
grep -hi 'реклам' claude_monet/owner_office/advertising_backup/* | grep -vi 'нагиев' | sort | wc -w

rm claude_monet/owner_office/nagiev_call_copy
rm owner_contract
rm claude_monet/owner_office/hall_access
rm claude_monet/contracts/supplier_duplicate
rm claude_monet/hall/vip_guests
rmdir claude_monet/hall
rmdir claude_monet/advertising
rm -r claude_monet/owner_office/advertising_backup
