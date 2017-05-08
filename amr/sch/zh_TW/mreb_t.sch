/* 
================================================================================
檔案代號:mreb_t
檔案名稱:資源設備盤點單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mreb_t
(
mrebent       number(5)      ,/* 企業編號 */
mrebsite       varchar2(10)      ,/* 營運據點 */
mrebdocno       varchar2(20)      ,/* 單據單號 */
mrebseq       number(10,0)      ,/* 項次 */
mreb001       varchar2(20)      ,/* 資源編號 */
mreb002       number(20,6)      ,/* 數量 */
mreb003       varchar2(20)      ,/* 保管人員 */
mreb004       varchar2(10)      ,/* 保管部門 */
mreb005       varchar2(255)      ,/* 一級存放位置 */
mreb006       varchar2(255)      ,/* 二級存放位置 */
mreb007       varchar2(1)      ,/* 資源盤點狀態 */
mreb008       number(20,6)      ,/* 盤點數量 */
mreb009       varchar2(255)      ,/* 備註 */
mreb010       varchar2(20)      ,/* 實際保管人員 */
mreb011       varchar2(10)      ,/* 實際保管部門 */
mreb012       varchar2(255)      ,/* 實際存放一級位置 */
mreb013       varchar2(255)      ,/* 實際存放二級位置 */
mreb014       date      ,/* 盤點日期 */
mreb015       varchar2(8)      ,/* 盤點時間 */
mrebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mreb_t add constraint mreb_pk primary key (mrebent,mrebdocno,mrebseq) enable validate;

create unique index mreb_pk on mreb_t (mrebent,mrebdocno,mrebseq);

grant select on mreb_t to tiptop;
grant update on mreb_t to tiptop;
grant delete on mreb_t to tiptop;
grant insert on mreb_t to tiptop;

exit;
