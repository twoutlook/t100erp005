/* 
================================================================================
檔案代號:stam_t
檔案名稱:自營合約異動申請單經營範圍設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stam_t
(
stament       number(5)      ,/* 企業編號 */
stamunit       varchar2(10)      ,/* 應用組織 */
stamsite       varchar2(10)      ,/* 營運據點 */
stamdocno       varchar2(20)      ,/* 單號 */
stamseq       number(10,0)      ,/* 項次 */
stam003       varchar2(10)      ,/* 品類編號 */
stam004       varchar2(1)      ,/* 可退貨否 */
stamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stamud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stam005       varchar2(1)      ,/* 主品類 */
stamacti       varchar2(1)      /* 有效 */
);
alter table stam_t add constraint stam_pk primary key (stament,stamdocno,stamseq) enable validate;

create unique index stam_pk on stam_t (stament,stamdocno,stamseq);

grant select on stam_t to tiptop;
grant update on stam_t to tiptop;
grant delete on stam_t to tiptop;
grant insert on stam_t to tiptop;

exit;
