/* 
================================================================================
檔案代號:xcar_t
檔案名稱:成本差異分攤科目大類設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcar_t
(
xcarent       number(5)      ,/* 企業編號 */
xcarld       varchar2(5)      ,/* 帳別編號 */
xcar001       varchar2(10)      ,/* 科目大類 */
xcar002       varchar2(24)      ,/* 科目編號 */
xcarownid       varchar2(20)      ,/* 資料所有者 */
xcarowndp       varchar2(10)      ,/* 資料所屬部門 */
xcarcrtid       varchar2(20)      ,/* 資料建立者 */
xcarcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcarcrtdt       timestamp(0)      ,/* 資料創建日 */
xcarmodid       varchar2(20)      ,/* 資料修改者 */
xcarmoddt       timestamp(0)      ,/* 最近修改日 */
xcarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcar_t add constraint xcar_pk primary key (xcarent,xcarld,xcar001,xcar002) enable validate;

create unique index xcar_pk on xcar_t (xcarent,xcarld,xcar001,xcar002);

grant select on xcar_t to tiptop;
grant update on xcar_t to tiptop;
grant delete on xcar_t to tiptop;
grant insert on xcar_t to tiptop;

exit;
