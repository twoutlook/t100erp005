/* 
================================================================================
檔案代號:mmfe_t
檔案名稱:贈品兌換單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmfe_t
(
mmfeent       number(5)      ,/* 企業編號 */
mmfesite       varchar2(10)      ,/* 營運據點 */
mmfeunit       varchar2(10)      ,/* 應用組織 */
mmfedocno       varchar2(20)      ,/* 單據編號 */
mmfeseq       number(10,0)      ,/* 項次 */
mmfe001       varchar2(40)      ,/* 商品編號 */
mmfe002       varchar2(256)      ,/* 特徵碼 */
mmfe003       varchar2(10)      ,/* 面額編號 */
mmfe004       varchar2(30)      ,/* 起始券號 */
mmfe005       varchar2(30)      ,/* 截止券號 */
mmfe006       number(20,6)      ,/* 加價金額 */
mmfe007       number(20,6)      ,/* 兌換份數 */
mmfe008       number(20,6)      ,/* 總兌換數量 */
mmfe009       number(20,6)      ,/* 加價總金額 */
mmfe010       varchar2(10)      ,/* 換贈庫位 */
mmfe011       varchar2(10)      ,/* 兌換方案組別 */
mmfe012       varchar2(10)      ,/* 資料類型 */
mmfe013       varchar2(40)      ,/* 資料編號 */
mmfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmfe_t add constraint mmfe_pk primary key (mmfeent,mmfedocno,mmfeseq) enable validate;

create unique index mmfe_pk on mmfe_t (mmfeent,mmfedocno,mmfeseq);

grant select on mmfe_t to tiptop;
grant update on mmfe_t to tiptop;
grant delete on mmfe_t to tiptop;
grant insert on mmfe_t to tiptop;

exit;
