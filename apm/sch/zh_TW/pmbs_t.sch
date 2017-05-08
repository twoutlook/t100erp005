/* 
================================================================================
檔案代號:pmbs_t
檔案名稱:供應商評核定性評分明細檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbs_t
(
pmbsent       number(5)      ,/* 企業編號 */
pmbssite       varchar2(10)      ,/* 營運據點 */
pmbsdocno       varchar2(20)      ,/* 單據編號 */
pmbsseq       number(10,0)      ,/* 項次 */
pmbs001       varchar2(10)      ,/* 供應商編號 */
pmbs002       varchar2(10)      ,/* 評核項目 */
pmbs003       number(5,0)      ,/* 分數 */
pmbsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbs_t add constraint pmbs_pk primary key (pmbsent,pmbsdocno,pmbsseq) enable validate;

create unique index pmbs_pk on pmbs_t (pmbsent,pmbsdocno,pmbsseq);

grant select on pmbs_t to tiptop;
grant update on pmbs_t to tiptop;
grant delete on pmbs_t to tiptop;
grant insert on pmbs_t to tiptop;

exit;
