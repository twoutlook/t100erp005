/* 
================================================================================
檔案代號:mmbc_t
檔案名稱:會員卡券調撥卡號明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbc_t
(
mmbcent       number(5)      ,/* 企業編號 */
mmbcsite       varchar2(10)      ,/* 營運據點 */
mmbcunit       varchar2(10)      ,/* 應用組織 */
mmbcdocno       varchar2(20)      ,/* 單據編號 */
mmbc000       varchar2(10)      ,/* 資料類型 */
mmbcseq       number(10,0)      ,/* 項次 */
mmbcseq1       number(10,0)      ,/* 序號 */
mmbc001       varchar2(30)      ,/* 開始卡號 */
mmbc002       varchar2(30)      ,/* 結束卡號 */
mmbc003       number(10,0)      ,/* 數量 */
mmbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbc_t add constraint mmbc_pk primary key (mmbcent,mmbcdocno,mmbcseq,mmbcseq1) enable validate;

create unique index mmbc_pk on mmbc_t (mmbcent,mmbcdocno,mmbcseq,mmbcseq1);

grant select on mmbc_t to tiptop;
grant update on mmbc_t to tiptop;
grant delete on mmbc_t to tiptop;
grant insert on mmbc_t to tiptop;

exit;
