/* 
================================================================================
檔案代號:nmef_t
檔案名稱:收支內容設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmef_t
(
nmefent       number(5)      ,/* 企業代碼 */
nmefownid       varchar2(20)      ,/* 資料所屬者 */
nmefowndp       varchar2(10)      ,/* 資料所屬部門 */
nmefcrtid       varchar2(20)      ,/* 資料建立者 */
nmefcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmefcrtdt       timestamp(0)      ,/* 資料創建日 */
nmefmodid       varchar2(20)      ,/* 資料修改者 */
nmefmoddt       timestamp(0)      ,/* 最近修改日 */
nmefstus       varchar2(10)      ,/* 狀態碼 */
nmef001       varchar2(10)      ,/* 收支項目版本 */
nmef002       varchar2(10)      ,/* 收支項目編號 */
nmef003       varchar2(3)      ,/* 細項 */
nmef004       varchar2(1)      ,/* 數據來源 */
nmefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmefud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmef005       number(5,0)      /* 追溯日期 */
);
alter table nmef_t add constraint nmef_pk primary key (nmefent,nmef001,nmef002,nmef003) enable validate;

create unique index nmef_pk on nmef_t (nmefent,nmef001,nmef002,nmef003);

grant select on nmef_t to tiptop;
grant update on nmef_t to tiptop;
grant delete on nmef_t to tiptop;
grant insert on nmef_t to tiptop;

exit;
