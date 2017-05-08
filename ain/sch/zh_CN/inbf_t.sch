/* 
================================================================================
檔案代號:inbf_t
檔案名稱:庫存異常變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inbf_t
(
inbfent       number(5)      ,/* 企業編號 */
inbfsite       varchar2(10)      ,/* 營運據點 */
inbfdocno       varchar2(20)      ,/* 單據編號 */
inbfdocdt       date      ,/* 輸入日期 */
inbf001       varchar2(20)      ,/* 申請人員 */
inbf002       varchar2(10)      ,/* 申請部門 */
inbf003       varchar2(10)      ,/* 理由碼 */
inbf004       varchar2(255)      ,/* 備註 */
inbfownid       varchar2(20)      ,/* 資料所有者 */
inbfowndp       varchar2(10)      ,/* 資料所屬部門 */
inbfcrtid       varchar2(20)      ,/* 資料建立者 */
inbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
inbfcrtdt       timestamp(0)      ,/* 資料創建日 */
inbfmodid       varchar2(20)      ,/* 資料修改者 */
inbfmoddt       timestamp(0)      ,/* 最近修改日 */
inbfcnfid       varchar2(20)      ,/* 資料確認者 */
inbfcnfdt       timestamp(0)      ,/* 資料確認日 */
inbfpstid       varchar2(20)      ,/* 資料過帳者 */
inbfpstdt       timestamp(0)      ,/* 資料過帳日 */
inbfstus       varchar2(10)      ,/* 狀態碼 */
inbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbf_t add constraint inbf_pk primary key (inbfent,inbfdocno) enable validate;

create unique index inbf_pk on inbf_t (inbfent,inbfdocno);

grant select on inbf_t to tiptop;
grant update on inbf_t to tiptop;
grant delete on inbf_t to tiptop;
grant insert on inbf_t to tiptop;

exit;
