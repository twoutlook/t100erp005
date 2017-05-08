/* 
================================================================================
檔案代號:isbf_t
檔案名稱:換開發票主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isbf_t
(
isbfent       number(5)      ,/* 企業代碼 */
isbfownid       varchar2(20)      ,/* 資料所有者 */
isbfowndp       varchar2(10)      ,/* 資料所屬部門 */
isbfcrtid       varchar2(20)      ,/* 資料建立者 */
isbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
isbfcrtdt       timestamp(0)      ,/* 資料創建日 */
isbfmodid       varchar2(20)      ,/* 資料修改者 */
isbfmoddt       timestamp(0)      ,/* 最近修改日 */
isbfcnfid       varchar2(20)      ,/* 資料確認者 */
isbfcnfdt       timestamp(0)      ,/* 資料確認日 */
isbfpstid       varchar2(20)      ,/* 資料過帳者 */
isbfpstdt       timestamp(0)      ,/* 資料過帳日 */
isbfstus       varchar2(10)      ,/* 狀態碼 */
isbfsite       varchar2(10)      ,/* 帳務中心 */
isbfcomp       varchar2(10)      ,/* 法人 */
isbfdocno       varchar2(20)      ,/* 異動單號 */
isbfdocdt       date      ,/* 單據日期 */
isbf001       varchar2(20)      ,/* 帳務人員 */
isbf002       date      ,/* 發票日期 */
isbf003       varchar2(10)      ,/* 換開理由 */
isbf004       varchar2(20)      ,/* 換開後購買方統編 */
isbf005       varchar2(10)      ,/* 換開後發票類型 */
isbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isbf_t add constraint isbf_pk primary key (isbfent,isbfcomp,isbfdocno) enable validate;

create unique index isbf_pk on isbf_t (isbfent,isbfcomp,isbfdocno);

grant select on isbf_t to tiptop;
grant update on isbf_t to tiptop;
grant delete on isbf_t to tiptop;
grant insert on isbf_t to tiptop;

exit;
