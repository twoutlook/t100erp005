/* 
================================================================================
檔案代號:sthf_t
檔案名稱:費用標準申請位置設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sthf_t
(
sthfent       number(5)      ,/* 企業編號 */
sthfsite       varchar2(10)      ,/* 營運組織 */
sthfunit       varchar2(10)      ,/* 應用組織 */
sthfdocno       varchar2(20)      ,/* 單據編號 */
sthfseq       number(10,0)      ,/* 項次 */
sthf001       varchar2(20)      ,/* 方案編號 */
sthf002       varchar2(10)      ,/* 樓棟編號 */
sthf003       varchar2(10)      ,/* 樓層編號 */
sthf004       varchar2(10)      ,/* 區域編號 */
sthf005       varchar2(10)      ,/* 品類編號 */
sthf006       varchar2(10)      ,/* 鋪位用途 */
sthf007       varchar2(20)      ,/* 鋪位編號 */
sthf008       varchar2(10)      ,/* 費用週期 */
sthf009       number(10,0)      ,/* 週期數值 */
sthf010       varchar2(10)      ,/* 計算類型 */
sthf011       varchar2(10)      ,/* 計算方式 */
sthfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sthfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sthfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sthfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sthfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sthfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sthfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sthfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sthfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sthfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sthfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sthfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sthfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sthfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sthfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sthfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sthfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sthfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sthfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sthfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sthfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sthfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sthfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sthfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sthfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sthfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sthfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sthfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sthfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sthfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sthf_t add constraint sthf_pk primary key (sthfent,sthfdocno,sthfseq) enable validate;

create unique index sthf_pk on sthf_t (sthfent,sthfdocno,sthfseq);

grant select on sthf_t to tiptop;
grant update on sthf_t to tiptop;
grant delete on sthf_t to tiptop;
grant insert on sthf_t to tiptop;

exit;
