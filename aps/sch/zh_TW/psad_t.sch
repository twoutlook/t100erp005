/* 
================================================================================
檔案代號:psad_t
檔案名稱:MPS計劃單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psad_t
(
psadent       number(5)      ,/* 企業編號 */
psadsite       varchar2(10)      ,/* 營運據點 */
psaddocno       varchar2(20)      ,/* MPS計劃單號 */
psadseq       number(10,0)      ,/* 項次 */
psad001       varchar2(40)      ,/* 料件編號 */
psad002       varchar2(256)      ,/* 產品特徵 */
psad003       date      ,/* 預計生產完工日期 */
psad004       varchar2(10)      ,/* 單位 */
psad005       number(20,6)      ,/* 計劃產量 */
psad006       number(20,6)      ,/* 已開工單量 */
psad007       varchar2(255)      ,/* 備註 */
psad008       varchar2(1)      ,/* 結案 */
psad009       varchar2(1)      ,/* MRP凍結 */
psadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psad_t add constraint psad_pk primary key (psadent,psaddocno,psadseq) enable validate;

create unique index psad_pk on psad_t (psadent,psaddocno,psadseq);

grant select on psad_t to tiptop;
grant update on psad_t to tiptop;
grant delete on psad_t to tiptop;
grant insert on psad_t to tiptop;

exit;
