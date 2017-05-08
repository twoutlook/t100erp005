/* 
================================================================================
檔案代號:stbq_t
檔案名稱:自營合約模板現返條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbq_t
(
stbqent       number(5)      ,/* 企業編號 */
stbq001       varchar2(10)      ,/* 模版編號 */
stbq002       number(10,0)      ,/* 序號 */
stbq003       varchar2(10)      ,/* 摘要編號 */
stbq004       varchar2(40)      ,/* 商品編號 */
stbq005       varchar2(10)      ,/* 現返條件 */
stbq006       varchar2(10)      ,/* 條件期間 */
stbq007       date      ,/* 起始日期 */
stbq008       date      ,/* 截止日期 */
stbq009       number(20,6)      ,/* 起始金額 */
stbq010       number(20,6)      ,/* 截止金額 */
stbq011       varchar2(10)      ,/* 計算基準 */
stbq012       varchar2(10)      ,/* 折扣方式 */
stbq013       number(20,6)      ,/* 折扣比率 */
stbq014       number(20,6)      ,/* 固定金額 */
stbq015       varchar2(10)      /* 理由碼 */
);
alter table stbq_t add constraint stbq_pk primary key (stbqent,stbq001,stbq002) enable validate;

create unique index stbq_pk on stbq_t (stbqent,stbq001,stbq002);

grant select on stbq_t to tiptop;
grant update on stbq_t to tiptop;
grant delete on stbq_t to tiptop;
grant insert on stbq_t to tiptop;

exit;
