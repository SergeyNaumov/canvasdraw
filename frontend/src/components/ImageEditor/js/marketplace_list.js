
export const marketplace_list=[
    {
        header:'Ozon',
        name: "ozon",
        src:'https://cdn1.ozone.ru/s3/cms/15/t4f/wc200/logo-logo-ozon-blue-png_1.png',
        size:'',
        sizes:[
            {
                width:1200,height:1500,header:'косметика, парфюмерия, товары для красоты, ювелирные изделия (1200x1500)'
            },
            {
                width:1500,height:1000,header:'test',min_width:1000
            },
        ],
        body: `
            <p>Поставщики, работающие на этой платформе, должны загружать снимки, со следующими характеристиками:<br>
                <ul>
                    <li>формат JPEG, PNG;</li>
                    <li>разрешение в пределах от 700 до 1600 пикселей</li>
                    <li>размер до 10 МБ</li>
                    <li>фон белый (для белых изделий – черный)</li>
                </ul>
            </p>` 
    },
    {
        header:'KazanExpress',
        name: "kazanexpress",
        src:'https://cdn1.ozone.ru/s3/cms/15/t4f/wc200/logo-logo-ozon-blue-png_1.png',
        size:0,
        sizes:[
                {width:1080,height:1440,header:'общие рекомендации (1080x1440)'}
        ],
        body: `
            <p>формат 3:4 (согласно новым изменениям в ЛК 2.0);<br>
            размеры снимков - 1080 x 1440 пикселей;<br>
            основные фото размещены на белом фоне (#efefef);<br>
            </p>` 
    },
    {
        header:'Wildberries',
        name: "wildberries",
        src:'https://cdn1.ozone.ru/s3/cms/15/t4f/wc200/logo-logo-ozon-blue-png_1.png',
        size:0,
        sizes:[{
                width: '900',
                height: '1200',
                header:'рекомендуемый размер (900x1200)'
        }],
        body: `
            <p>
                Пропорции 3:4<br>
                Минимальное разрешение: 900x1200 пикселей<br>
                Содержание фотографий:<br>
                нейтральный, чистый фон, не отвлекающий внимание;<br>
                презентабельный вид покрытия стен и пола при модельной съемке
            </p>` 
    },
    {
        header:'AliExpress',
        name: "aliexpress",
        src:'https://cdn1.ozone.ru/s3/cms/15/t4f/wc200/logo-logo-ozon-blue-png_1.png',
        size:0,
        sizes:[
            {
                header:'пропорции 1x1 от 800x800 до 1000x1000',
                width:1000,
                height:1000,
/*
                min_width: 800,
                min_height: 800,
                max_width: 1000,
                max_height: 1000
*/
            }
        ],
        body: `
            <p>
                Соотношение сторон — 1:1 или 3:4.<br>
                Разрешение:<br>
                для 1:1 — от 800 × 800px до 1000 × 1000px;<br>
                для 3:4 — от 600 × 800px до 750 × 1000px.
            </p>` 
    },
]

