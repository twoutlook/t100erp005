/* 
================================================================================
檔案代號:fmmz_t
檔案名稱:平倉出售費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmz_t
(
fmmzent       number(5)      ,/* 企業代碼 */
fmmzownid       varchar2(20)      ,/* 資料所有者 */
fmmzowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmzcrtid       varchar2(20)      ,/* 資料建立者 */
fmmzcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmzcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmzmodid       varchar2(20)      ,/* 資料修改者 */
fmmzmoddt       timestamp(0)      ,/* 最近修改日 */
fmmzcnfid       varchar2(20)      ,/* 資料確認者 */
fmmzcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmzpstid       varchar2(20)      ,/* 資料過帳者 */
fmmzpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmzstus       varchar2(10)      ,/* 狀態碼 */
fmmzdocno       varchar2(20)      ,/* 單號 */
fmmzseq       number(10,0)      ,/* 項次 */
fmmz001       varchar2(10)      ,/* 費用類型 */
fmmz002       varchar2(10)      ,/* 幣別 */
fmmz003       number(20,6)      ,/* 金額 */
fmmz004       number(20,10)      ,/* 匯率 */
fmmz005       varchar2(1)      ,/* 使用市場資金帳戶 */
fmmz006       varchar2(30)      ,/* 銀行收支單號 */
fmmz007       number(10,0)      ,/* 收支單項次 */
fmmzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmzud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmz008       varchar2(10)      ,/* 銀行帳戶 */
fmmz009       varchar2(10)      ,/* 現金變動碼 */
fmmz010       varchar2(10)      ,/* 存提碼 */
fmmz011       number(20,6)      /* 本幣金額 */
);
alter table fmmz_t add constraint fmmz_pk primary key (fmmzent,fmmzdocno,fmmzseq) enable validate;

create unique index fmmz_pk on fmmz_t (fmmzent,fmmzdocno,fmmzseq);

grant select on fmmz_t to tiptop;
grant update on fmmz_t to tiptop;
grant delete on fmmz_t to tiptop;
grant insert on fmmz_t to tiptop;

exit;
