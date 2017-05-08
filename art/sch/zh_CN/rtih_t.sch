/* 
================================================================================
檔案代號:rtih_t
檔案名稱:銷售交易刷卡明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtih_t
(
rtihent       number(5)      ,/* 企業編號 */
rtihsite       varchar2(10)      ,/* 營運據點 */
rtihunit       varchar2(10)      ,/* 應用組織 */
rtihdocno       varchar2(20)      ,/* 單據編號 */
rtihseq1       number(10,0)      ,/* 刷卡序號 */
rtih001       varchar2(10)      ,/* 作業類型 */
rtih002       varchar2(10)      ,/* 刷卡機號 */
rtih003       varchar2(30)      ,/* 卡號 */
rtih004       number(20,6)      ,/* 刷卡金額 */
rtih005       timestamp(0)      ,/* 刷卡日期時間 */
rtih006       varchar2(20)      ,/* 刷卡人員 */
rtih007       number(20,6)      ,/* 固定手續費 */
rtih008       number(20,6)      ,/* 刷卡手續費 */
rtih009       number(20,6)      ,/* 刷卡手續費率 */
rtih010       varchar2(15)      ,/* 銀行編號 */
rtih011       varchar2(10)      ,/* 刷卡狀態 */
rtihud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtihud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtihud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtihud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtihud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtihud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtihud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtihud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtihud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtihud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtihud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtihud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtihud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtihud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtihud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtihud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtihud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtihud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtihud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtihud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtihud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtihud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtihud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtihud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtihud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtihud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtihud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtihud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtihud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtihud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtih_t add constraint rtih_pk primary key (rtihent,rtihdocno,rtihseq1) enable validate;

create unique index rtih_pk on rtih_t (rtihent,rtihdocno,rtihseq1);

grant select on rtih_t to tiptop;
grant update on rtih_t to tiptop;
grant delete on rtih_t to tiptop;
grant insert on rtih_t to tiptop;

exit;
