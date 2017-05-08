/* 
================================================================================
檔案代號:stbi_t
檔案名稱:促銷協議明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbi_t
(
stbient       number(5)      ,/* 企業編號 */
stbiunit       varchar2(10)      ,/* 制定組織 */
stbisite       varchar2(10)      ,/* 營運組織 */
stbidocno       varchar2(20)      ,/* 單號編號 */
stbiseq       number(10,0)      ,/* 項次 */
stbi001       varchar2(40)      ,/* 商品編號 */
stbi002       varchar2(40)      ,/* 商品條碼 */
stbi003       varchar2(256)      ,/* 商品特征 */
stbi004       varchar2(10)      ,/* 進價計價單位 */
stbi005       varchar2(10)      ,/* 進項稅別 */
stbi006       date      ,/* 採購起始日期 */
stbi007       date      ,/* 採購截止日期 */
stbi008       number(20,6)      ,/* 促銷進價 */
stbi009       varchar2(10)      ,/* 售價計價單位 */
stbi010       varchar2(10)      ,/* 銷項稅別 */
stbi011       date      ,/* 銷售起始日期 */
stbi012       date      ,/* 銷售截止日期 */
stbi013       number(20,6)      ,/* 促銷售價 */
stbi014       number(20,6)      ,/* 會員價1 */
stbi015       number(20,6)      ,/* 會員價2 */
stbi016       number(20,6)      ,/* 會員價3 */
stbi017       number(20,6)      ,/* 結算扣率 */
stbi018       varchar2(10)      ,/* 貨架類型 */
stbi019       varchar2(10)      ,/* 貨架編號 */
stbi020       varchar2(80)      ,/* 位置說明 */
stbi021       varchar2(10)      ,/* 陳列費用編號 */
stbi022       number(20,6)      ,/* 費用金額 */
stbi023       date      ,/* 費用計算日期 */
stbi024       varchar2(10)      ,/* 費用計算狀態 */
stbi025       varchar2(10)      ,/* 補差類型 */
stbi026       varchar2(10)      ,/* 補差方式 */
stbi027       number(20,6)      ,/* 差價/基準價/毛利率 */
stbi028       date      ,/* 補差計算日期 */
stbi029       varchar2(10)      ,/* 補差計算狀態 */
stbi030       number(20,6)      ,/* 費用承擔比例% */
stbi031       number(20,6)      ,/* 補差承擔比例% */
stbi032       number(20,6)      /* 原結算扣率 */
);
alter table stbi_t add constraint stbi_pk primary key (stbient,stbidocno,stbiseq) enable validate;

create unique index stbi_pk on stbi_t (stbient,stbidocno,stbiseq);

grant select on stbi_t to tiptop;
grant update on stbi_t to tiptop;
grant delete on stbi_t to tiptop;
grant insert on stbi_t to tiptop;

exit;
