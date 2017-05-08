/* 
================================================================================
檔案代號:glde_t
檔案名稱:合併組織股本異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glde_t
(
gldeent       number(5)      ,/* 企業編號 */
gldedocno       varchar2(20)      ,/* 單據編號 */
gldeseq       number(10,0)      ,/* 項次 */
glde001       varchar2(10)      ,/* 下層公司(異動前) */
glde002       varchar2(10)      ,/* 下層公司(異動後) */
glde003       varchar2(5)      ,/* 帳套(下層公司)(異動前) */
glde004       varchar2(5)      ,/* 帳套(下層公司)(異動後) */
glde005       number(20,6)      ,/* 持股比率%(異動前) */
glde006       number(20,6)      ,/* 持股比率%(異動後) */
glde007       varchar2(1)      ,/* 納入合併否(異動前) */
glde008       varchar2(1)      ,/* 納入合併否(異動後) */
glde009       number(10,0)      ,/* 投資股數(異動前) */
glde010       number(10,0)      ,/* 投資股數(異動前) */
glde011       number(20,6)      ,/* 股本(異動前) */
glde012       number(20,6)      ,/* 股本(異動後) */
glde013       date      ,/* 異動日期(異動前) */
glde014       date      ,/* 異動日期(異動後) */
glde015       varchar2(1)      ,/* 異動類型 */
gldeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glde_t add constraint glde_pk primary key (gldeent,gldedocno,gldeseq) enable validate;

create unique index glde_pk on glde_t (gldeent,gldedocno,gldeseq);

grant select on glde_t to tiptop;
grant update on glde_t to tiptop;
grant delete on glde_t to tiptop;
grant insert on glde_t to tiptop;

exit;
