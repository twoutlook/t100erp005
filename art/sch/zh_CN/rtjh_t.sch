/* 
================================================================================
檔案代號:rtjh_t
檔案名稱:銷售整合刷卡明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjh_t
(
rtjhent       number(5)      ,/* 企業編號 */
rtjhsite       varchar2(10)      ,/* 營運據點 */
rtjhunit       varchar2(10)      ,/* 應用組織 */
rtjhdocno       varchar2(20)      ,/* 單據編號 */
rtjhseq1       number(10,0)      ,/* 刷卡序號 */
rtjh001       varchar2(10)      ,/* 作業類型 */
rtjh002       varchar2(10)      ,/* 刷卡機號 */
rtjh003       varchar2(30)      ,/* 卡號 */
rtjh004       number(20,6)      ,/* 刷卡金額 */
rtjh005       timestamp(0)      ,/* 刷卡日期時間 */
rtjh006       varchar2(20)      ,/* 刷卡人員 */
rtjh007       number(20,6)      ,/* 固定手續費 */
rtjh008       number(20,6)      ,/* 刷卡手續費 */
rtjh009       number(20,6)      ,/* 刷卡手續費率 */
rtjh010       varchar2(15)      ,/* 銀行編號 */
rtjh011       varchar2(10)      ,/* 刷卡狀態 */
rtjhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjh_t add constraint rtjh_pk primary key (rtjhent,rtjhdocno,rtjhseq1) enable validate;

create unique index rtjh_pk on rtjh_t (rtjhent,rtjhdocno,rtjhseq1);

grant select on rtjh_t to tiptop;
grant update on rtjh_t to tiptop;
grant delete on rtjh_t to tiptop;
grant insert on rtjh_t to tiptop;

exit;
