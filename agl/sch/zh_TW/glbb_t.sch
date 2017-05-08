/* 
================================================================================
檔案代號:glbb_t
檔案名稱:帳別部門設限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glbb_t
(
glbbent       number(5)      ,/* 企業編號 */
glbbownid       varchar2(20)      ,/* 資料所有者 */
glbbowndp       varchar2(10)      ,/* 資料所屬部門 */
glbbcrtid       varchar2(20)      ,/* 資料建立者 */
glbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
glbbcrtdt       timestamp(0)      ,/* 資料創建日 */
glbbmodid       varchar2(20)      ,/* 資料修改者 */
glbbmoddt       timestamp(0)      ,/* 最近修改日 */
glbbstus       varchar2(10)      ,/* 狀態碼 */
glbbld       varchar2(5)      ,/* 帳別 */
glbb001       varchar2(10)      ,/* 部門編號 */
glbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glbb_t add constraint glbb_pk primary key (glbbent,glbbld,glbb001) enable validate;

create unique index glbb_pk on glbb_t (glbbent,glbbld,glbb001);

grant select on glbb_t to tiptop;
grant update on glbb_t to tiptop;
grant delete on glbb_t to tiptop;
grant insert on glbb_t to tiptop;

exit;
