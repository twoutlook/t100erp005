/* 
================================================================================
檔案代號:fmmc_t
檔案名稱:投資費用類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmmc_t
(
fmmcent       number(5)      ,/* 企業代碼 */
fmmcownid       varchar2(20)      ,/* 資料所有者 */
fmmcowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmccrtid       varchar2(20)      ,/* 資料建立者 */
fmmccrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmccrtdt       timestamp(0)      ,/* 資料創建日 */
fmmcmodid       varchar2(20)      ,/* 資料修改者 */
fmmcmoddt       timestamp(0)      ,/* 最近修改日 */
fmmcstus       varchar2(10)      ,/* 狀態碼 */
fmmc001       varchar2(10)      ,/* 投資費用類型 */
fmmcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmc_t add constraint fmmc_pk primary key (fmmcent,fmmc001) enable validate;

create unique index fmmc_pk on fmmc_t (fmmcent,fmmc001);

grant select on fmmc_t to tiptop;
grant update on fmmc_t to tiptop;
grant delete on fmmc_t to tiptop;
grant insert on fmmc_t to tiptop;

exit;
