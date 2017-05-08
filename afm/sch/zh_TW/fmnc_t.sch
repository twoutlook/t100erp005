/* 
================================================================================
檔案代號:fmnc_t
檔案名稱:資金帳戶科目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmnc_t
(
fmncent       number(5)      ,/* 企業編號 */
fmncsite       varchar2(10)      ,/* 投資組織 */
fmnc001       varchar2(5)      ,/* 帳套 */
fmnc002       varchar2(10)      ,/* 交易市場編號 */
fmnc003       varchar2(24)      ,/* 資金帳戶科目 */
fmncownid       varchar2(20)      ,/* 資料所有者 */
fmncowndp       varchar2(10)      ,/* 資料所屬部門 */
fmnccrtid       varchar2(20)      ,/* 資料建立者 */
fmnccrtdp       varchar2(10)      ,/* 資料建立部門 */
fmnccrtdt       timestamp(0)      ,/* 資料創建日 */
fmncmodid       varchar2(20)      ,/* 資料修改者 */
fmncmoddt       timestamp(0)      ,/* 最近修改日 */
fmncstus       varchar2(10)      ,/* 狀態碼 */
fmncud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmncud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmncud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmncud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmncud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmncud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmncud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmncud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmncud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmncud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmncud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmncud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmncud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmncud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmncud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmncud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmncud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmncud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmncud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmncud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmncud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmncud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmncud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmncud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmncud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmncud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmncud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmncud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmncud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmncud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmnc_t add constraint fmnc_pk primary key (fmncent,fmncsite,fmnc001,fmnc002) enable validate;

create unique index fmnc_pk on fmnc_t (fmncent,fmncsite,fmnc001,fmnc002);

grant select on fmnc_t to tiptop;
grant update on fmnc_t to tiptop;
grant delete on fmnc_t to tiptop;
grant insert on fmnc_t to tiptop;

exit;
