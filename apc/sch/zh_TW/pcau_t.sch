/* 
================================================================================
檔案代號:pcau_t
檔案名稱:解款單資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcau_t
(
pcauent       number(5)      ,/* 企業代碼 */
pcausite       varchar2(10)      ,/* 營運據點 */
pcau001       varchar2(40)      ,/* 解款單ID */
pcau002       varchar2(10)      ,/* 收銀機編號 */
pcau003       varchar2(10)      ,/* 班次編號 */
pcau004       varchar2(10)      ,/* 收銀員編號 */
pcau005       date      ,/* 營業日期 */
pcau006       date      ,/* 系統日期 */
pcau007       varchar2(8)      ,/* 系統時間 */
pcau008       number(10,0)      ,/* 100元面額張數 */
pcau009       number(10,0)      ,/* 50元面額張數 */
pcau010       number(20,6)      ,/* 總金額 */
pcau011       varchar2(10)      ,/* 授權人員 */
pcau012       varchar2(80)      ,/* 授權姓名 */
pcaustus       varchar2(10)      ,/* 狀態碼 */
pcauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcau_t add constraint pcau_pk primary key (pcauent,pcau001) enable validate;

create unique index pcau_pk on pcau_t (pcauent,pcau001);

grant select on pcau_t to tiptop;
grant update on pcau_t to tiptop;
grant delete on pcau_t to tiptop;
grant insert on pcau_t to tiptop;

exit;
