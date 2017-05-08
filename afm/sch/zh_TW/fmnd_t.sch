/* 
================================================================================
檔案代號:fmnd_t
檔案名稱:收息費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmnd_t
(
fmndent       number(5)      ,/* 企業代碼 */
fmnddocno       varchar2(20)      ,/* 單號 */
fmndseq       number(10,0)      ,/* 項次 */
fmnd001       varchar2(10)      ,/* 費用類型 */
fmnd002       varchar2(10)      ,/* 幣別 */
fmnd003       number(20,6)      ,/* 金額 */
fmnd004       number(20,10)      ,/* 匯率 */
fmnd005       varchar2(1)      ,/* 使用市場資金帳戶 */
fmnd006       varchar2(30)      ,/* NO USE */
fmnd007       number(10,0)      ,/* NO USE */
fmndownid       varchar2(20)      ,/* 資料所有者 */
fmndowndp       varchar2(10)      ,/* 資料所屬部門 */
fmndcrtid       varchar2(20)      ,/* 資料建立者 */
fmndcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmndcrtdt       timestamp(0)      ,/* 資料創建日 */
fmndmodid       varchar2(20)      ,/* 資料修改者 */
fmndmoddt       timestamp(0)      ,/* 最近修改日 */
fmndcnfid       varchar2(20)      ,/* 資料確認者 */
fmndcnfdt       timestamp(0)      ,/* 資料確認日 */
fmndpstid       varchar2(20)      ,/* 資料過帳者 */
fmndpstdt       timestamp(0)      ,/* 資料過帳日 */
fmndstus       varchar2(10)      ,/* 狀態碼 */
fmndud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmndud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmndud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmndud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmndud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmndud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmndud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmndud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmndud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmndud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmndud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmndud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmndud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmndud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmndud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmndud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmndud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmndud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmndud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmndud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmndud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmndud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmndud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmndud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmndud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmndud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmndud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmndud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmndud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmndud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmnd008       varchar2(10)      ,/* 支付帳戶 */
fmnd009       varchar2(10)      ,/* 現金變動碼 */
fmnd010       varchar2(10)      ,/* 存提碼 */
fmnd011       number(20,6)      /* 本幣金額 */
);
alter table fmnd_t add constraint fmnd_pk primary key (fmndent,fmnddocno,fmndseq) enable validate;

create unique index fmnd_pk on fmnd_t (fmndent,fmnddocno,fmndseq);

grant select on fmnd_t to tiptop;
grant update on fmnd_t to tiptop;
grant delete on fmnd_t to tiptop;
grant insert on fmnd_t to tiptop;

exit;
