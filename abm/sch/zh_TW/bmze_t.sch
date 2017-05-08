/* 
================================================================================
檔案代號:bmze_t
檔案名稱:BOM用量公式單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bmze_t
(
bmzeent       number(5)      ,/* 企業編號 */
bmzestus       varchar2(10)      ,/* 狀態碼 */
bmze001       varchar2(10)      ,/* 公式代號 */
bmze002       varchar2(255)      ,/* 公式說明 */
bmze003       varchar2(500)      ,/* 公式 */
bmzeownid       varchar2(20)      ,/* 資料所有者 */
bmzeowndp       varchar2(10)      ,/* 資料所屬部門 */
bmzecrtid       varchar2(20)      ,/* 資料建立者 */
bmzecrtdp       varchar2(10)      ,/* 資料建立部門 */
bmzecrtdt       timestamp(0)      ,/* 資料創建日 */
bmzemodid       varchar2(20)      ,/* 資料修改者 */
bmzemoddt       timestamp(0)      ,/* 最近修改日 */
bmzeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmzeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmzeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmzeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmzeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmzeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmzeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmzeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmzeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmzeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmzeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmzeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmzeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmzeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmzeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmzeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmzeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmzeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmzeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmzeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmzeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmzeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmzeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmzeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmzeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmzeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmzeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmzeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmzeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmzeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmze_t add constraint bmze_pk primary key (bmzeent,bmze001) enable validate;

create  index bmze_01 on bmze_t (bmze001);
create unique index bmze_pk on bmze_t (bmzeent,bmze001);

grant select on bmze_t to tiptop;
grant update on bmze_t to tiptop;
grant delete on bmze_t to tiptop;
grant insert on bmze_t to tiptop;

exit;
