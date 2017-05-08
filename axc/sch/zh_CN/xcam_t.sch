/* 
================================================================================
檔案代號:xcam_t
檔案名稱:自製品成本次要素分配率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcam_t
(
xcament       number(5)      ,/* 企業編號 */
xcamsite       varchar2(10)      ,/* 營運據點 */
xcamseq       number(10,0)      ,/* 項次 */
xcam001       varchar2(40)      ,/* 料號 */
xcam002       varchar2(10)      ,/* 主分群 */
xcam003       varchar2(10)      ,/* 成本分群 */
xcam004       varchar2(10)      ,/* 成本次要素 */
xcam005       number(20,6)      ,/* 分配率 */
xcamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcam_t add constraint xcam_pk primary key (xcament,xcamsite,xcamseq) enable validate;

create unique index xcam_pk on xcam_t (xcament,xcamsite,xcamseq);

grant select on xcam_t to tiptop;
grant update on xcam_t to tiptop;
grant delete on xcam_t to tiptop;
grant insert on xcam_t to tiptop;

exit;
