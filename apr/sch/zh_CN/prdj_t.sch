/* 
================================================================================
檔案代號:prdj_t
檔案名稱:促銷規則申請換贈設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdj_t
(
prdjent       number(5)      ,/* 企業編號 */
prdjunit       varchar2(10)      ,/* 應用組織 */
prdjsite       varchar2(10)      ,/* 營運據點 */
prdjdocno       varchar2(20)      ,/* 促銷申請單號 */
prdj001       varchar2(20)      ,/* 規則編號 */
prdj002       number(10,0)      ,/* 換贈組別 */
prdj003       number(10,0)      ,/* 條件組別 */
prdj004       number(10,0)      ,/* 對象組別 */
prdj005       number(10,0)      ,/* 換贈數量 */
prdj006       number(20,6)      ,/* 加價金額 */
prdjacti       varchar2(10)      ,/* 有效否 */
prdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdj_t add constraint prdj_pk primary key (prdjent,prdjdocno,prdj002,prdj003,prdj004) enable validate;

create unique index prdj_pk on prdj_t (prdjent,prdjdocno,prdj002,prdj003,prdj004);

grant select on prdj_t to tiptop;
grant update on prdj_t to tiptop;
grant delete on prdj_t to tiptop;
grant insert on prdj_t to tiptop;

exit;
