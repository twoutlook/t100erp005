/* 
================================================================================
檔案代號:mmbb_t
檔案名稱:會員卡券調撥單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbb_t
(
mmbbent       number(5)      ,/* 企業編號 */
mmbbsite       varchar2(10)      ,/* 營運據點 */
mmbbunit       varchar2(10)      ,/* 應用組織 */
mmbbdocno       varchar2(20)      ,/* 單據編號 */
mmbb000       varchar2(10)      ,/* 資料類型 */
mmbbseq       number(10,0)      ,/* 項次 */
mmbb001       varchar2(10)      ,/* 卡種編號 */
mmbb002       varchar2(10)      ,/* 領出庫區 */
mmbb003       varchar2(10)      ,/* 領用組織 */
mmbb004       varchar2(10)      ,/* 領用庫區 */
mmbb005       number(10,0)      ,/* 申請數量 */
mmbb006       number(10,0)      ,/* 確認數量 */
mmbb007       varchar2(20)      ,/* 領用申請單號 */
mmbb008       number(10,0)      ,/* 領用申請單項次 */
mmbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbb_t add constraint mmbb_pk primary key (mmbbent,mmbbdocno,mmbbseq) enable validate;

create unique index mmbb_pk on mmbb_t (mmbbent,mmbbdocno,mmbbseq);

grant select on mmbb_t to tiptop;
grant update on mmbb_t to tiptop;
grant delete on mmbb_t to tiptop;
grant insert on mmbb_t to tiptop;

exit;
