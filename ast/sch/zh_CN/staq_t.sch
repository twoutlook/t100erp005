/* 
================================================================================
檔案代號:staq_t
檔案名稱:自營合約經營範圍設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table staq_t
(
staqent       number(5)      ,/* 企業編號 */
staq001       varchar2(20)      ,/* 合約編號 */
staq002       number(10,0)      ,/* 項次 */
staq003       varchar2(10)      ,/* 品類編號 */
staq004       varchar2(1)      ,/* 可退貨否 */
staqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staqud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
staq005       varchar2(1)      ,/* 主部類 */
staqacti       varchar2(1)      /* 有效 */
);
alter table staq_t add constraint staq_pk primary key (staqent,staq001,staq002) enable validate;

create unique index staq_pk on staq_t (staqent,staq001,staq002);

grant select on staq_t to tiptop;
grant update on staq_t to tiptop;
grant delete on staq_t to tiptop;
grant insert on staq_t to tiptop;

exit;
