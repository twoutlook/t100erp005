/* 
================================================================================
檔案代號:prdm_t
檔案名稱:促銷規則對象主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdm_t
(
prdment       number(5)      ,/* 企業編號 */
prdmunit       varchar2(10)      ,/* 應用組織 */
prdmsite       varchar2(10)      ,/* 營運據點 */
prdm001       varchar2(20)      ,/* 規則編號 */
prdm002       number(10,0)      ,/* 組別 */
prdm003       varchar2(10)      ,/* 對象類別 */
prdm004       number(10,0)      ,/* 條件組別 */
prdm005       number(20,6)      ,/* 促銷值 */
prdmstus       varchar2(10)      ,/* 有效否 */
prdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdmud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdm006       varchar2(1)      ,/* 積分優惠 */
prdm007       number(15,3)      ,/* 積分基準 */
prdm008       number(15,3)      ,/* 單位積分 */
prdm009       number(15,3)      ,/* 加送積分 */
prdm010       number(5,0)      ,/* 會員達成次數限制 */
prdm011       number(5,0)      ,/* 總會員達成次數限制 */
prdm012       number(20,6)      ,/* 基數 */
prdm013       number(20,6)      ,/* 倍數 */
prdm014       number(10,0)      /* 對象幅度 */
);
alter table prdm_t add constraint prdm_pk primary key (prdment,prdm001,prdm002,prdm004) enable validate;

create unique index prdm_pk on prdm_t (prdment,prdm001,prdm002,prdm004);

grant select on prdm_t to tiptop;
grant update on prdm_t to tiptop;
grant delete on prdm_t to tiptop;
grant insert on prdm_t to tiptop;

exit;
