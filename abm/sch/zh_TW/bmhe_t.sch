/* 
================================================================================
檔案代號:bmhe_t
檔案名稱:料件承認模板單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bmhe_t
(
bmheent       number(5)      ,/* 企業代碼 */
bmheownid       varchar2(20)      ,/* 資料所有者 */
bmheowndp       varchar2(10)      ,/* 資料所屬部門 */
bmhecrtid       varchar2(20)      ,/* 資料建立者 */
bmhecrtdp       varchar2(10)      ,/* 資料建立部門 */
bmhecrtdt       timestamp(0)      ,/* 資料創建日 */
bmhemodid       varchar2(20)      ,/* 資料修改者 */
bmhemoddt       timestamp(0)      ,/* 最近修改日 */
bmhestus       varchar2(10)      ,/* 狀態碼 */
bmhe001       varchar2(10)      ,/* 模板代號 */
bmhe002       varchar2(1)      ,/* 正負向表列 */
bmheud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmheud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmheud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmheud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmheud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmheud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmheud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmheud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmheud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmheud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmheud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmheud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmheud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmheud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmheud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmheud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmheud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmheud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmheud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmheud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmheud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmheud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmheud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmheud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmheud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmheud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmheud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmheud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmheud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmheud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmhe_t add constraint bmhe_pk primary key (bmheent,bmhe001) enable validate;

create unique index bmhe_pk on bmhe_t (bmheent,bmhe001);

grant select on bmhe_t to tiptop;
grant update on bmhe_t to tiptop;
grant delete on bmhe_t to tiptop;
grant insert on bmhe_t to tiptop;

exit;
