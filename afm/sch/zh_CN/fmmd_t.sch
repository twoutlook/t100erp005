/* 
================================================================================
檔案代號:fmmd_t
檔案名稱:投資費用科目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmmd_t
(
fmmdent       number(5)      ,/* 企業代碼 */
fmmdownid       varchar2(20)      ,/* 資料所有者 */
fmmdowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmdcrtid       varchar2(20)      ,/* 資料建立者 */
fmmdcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmdcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmdmodid       varchar2(20)      ,/* 資料修改者 */
fmmdmoddt       timestamp(0)      ,/* 最近修改日 */
fmmdstus       varchar2(10)      ,/* 狀態碼 */
fmmdld       varchar2(5)      ,/* 帳別 */
fmmd001       varchar2(10)      ,/* 投資類型 */
fmmd002       varchar2(10)      ,/* 投資費用類型 */
fmmd003       varchar2(24)      ,/* 科目編號 */
fmmdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmd_t add constraint fmmd_pk primary key (fmmdent,fmmdld,fmmd001,fmmd002) enable validate;

create unique index fmmd_pk on fmmd_t (fmmdent,fmmdld,fmmd001,fmmd002);

grant select on fmmd_t to tiptop;
grant update on fmmd_t to tiptop;
grant delete on fmmd_t to tiptop;
grant insert on fmmd_t to tiptop;

exit;
