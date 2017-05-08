/* 
================================================================================
檔案代號:mmdb_t
檔案名稱:會員卡資訊重計變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdb_t
(
mmdbent       number(5)      ,/* 企業編號 */
mmdbunit       varchar2(10)      ,/* 應用組織 */
mmdbsite       varchar2(10)      ,/* 營運據點 */
mmdbdocno       varchar2(20)      ,/* 單號 */
mmdbseq       number(10,0)      ,/* 項次 */
mmdb001       varchar2(30)      ,/* 會員卡號 */
mmdb002       date      ,/* 變更前最後消費日 */
mmdb003       date      ,/* 變更後最後消費日 */
mmdb004       number(5,0)      ,/* 變更前累計消費次數 */
mmdb005       number(5,0)      ,/* 變更後累計消費次數 */
mmdb006       number(20,6)      ,/* 變更前累計消費金額 */
mmdb007       number(20,6)      ,/* 變更後累計消費金額 */
mmdb008       number(15,3)      ,/* 變更前累計積點 */
mmdb009       number(15,3)      ,/* 變更後累計積點 */
mmdb010       number(15,3)      ,/* 變更前已兌換積點 */
mmdb011       number(15,3)      ,/* 變更後已兌換積點 */
mmdb012       number(15,3)      ,/* 變更前剩餘積點 */
mmdb013       number(15,3)      ,/* 變更後剩餘積點 */
mmdb014       number(20,6)      ,/* 變更前會員卡儲值餘額 */
mmdb015       number(20,6)      ,/* 變更後會員卡儲值餘額 */
mmdb016       number(20,6)      ,/* 變更前會員卡累計儲值折扣金額 */
mmdb017       number(20,6)      ,/* 變更後會員卡累計儲值折扣金額 */
mmdb018       number(20,6)      ,/* 變更前會員卡累計加值金額 */
mmdb019       number(20,6)      ,/* 變更後會員卡累計加值金額 */
mmdb020       number(20,6)      ,/* 變更前會員卡累計送抵現值金額 */
mmdb021       number(20,6)      ,/* 變更後會員卡累計送抵現值金額 */
mmdb022       number(20,6)      ,/* 變更前會員卡累計儲值餘額成本 */
mmdb023       number(20,6)      ,/* 變更後會員卡累計儲值餘額成本 */
mmdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmdb_t add constraint mmdb_pk primary key (mmdbent,mmdbdocno,mmdbseq) enable validate;

create unique index mmdb_pk on mmdb_t (mmdbent,mmdbdocno,mmdbseq);

grant select on mmdb_t to tiptop;
grant update on mmdb_t to tiptop;
grant delete on mmdb_t to tiptop;
grant insert on mmdb_t to tiptop;

exit;
