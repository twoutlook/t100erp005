/* 
================================================================================
檔案代號:sfkh_t
檔案名稱:工單變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfkh_t
(
sfkhent       number(5)      ,/* 企業編號 */
sfkhsite       varchar2(10)      ,/* 營運據點 */
sfkhdocno       varchar2(20)      ,/* 工單單號 */
sfkhseq       number(10,0)      ,/* 項次 */
sfkhseq1       number(10,0)      ,/* 項序 */
sfkh001       number(10,0)      ,/* 變更序 */
sfkh002       varchar2(20)      ,/* 變更欄位 */
sfkh003       varchar2(10)      ,/* 變更類型 */
sfkh004       varchar2(255)      ,/* 變更前內容 */
sfkh005       varchar2(255)      ,/* 變更後內容 */
sfkh006       varchar2(80)      ,/* 最後變更時間 */
sfkh007       varchar2(500)      ,/* 欄位說明SQL */
sfkhownid       varchar2(20)      ,/* 資料所有者 */
sfkhowndp       varchar2(10)      ,/* 資料所有部門 */
sfkhcrtid       varchar2(20)      ,/* 資料建立者 */
sfkhcrtdp       varchar2(10)      ,/* 資料建立部門 */
sfkhcrtdt       timestamp(0)      ,/* 資料創建日 */
sfkhmodid       varchar2(20)      ,/* 資料修改者 */
sfkhmoddt       timestamp(0)      ,/* 最近修改日 */
sfkhcnfid       varchar2(20)      ,/* 資料確認者 */
sfkhcnfdt       timestamp(0)      ,/* 資料確認日 */
sfkhpstid       varchar2(20)      ,/* 資料過帳者 */
sfkhpstdt       timestamp(0)      ,/* 資料過帳日 */
sfkhstus       varchar2(10)      ,/* 狀態碼 */
sfkhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfkh_t add constraint sfkh_pk primary key (sfkhent,sfkhdocno,sfkhseq,sfkhseq1,sfkh001,sfkh002) enable validate;

create unique index sfkh_pk on sfkh_t (sfkhent,sfkhdocno,sfkhseq,sfkhseq1,sfkh001,sfkh002);

grant select on sfkh_t to tiptop;
grant update on sfkh_t to tiptop;
grant delete on sfkh_t to tiptop;
grant insert on sfkh_t to tiptop;

exit;
