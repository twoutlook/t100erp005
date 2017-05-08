/* 
================================================================================
檔案代號:stid_t
檔案名稱:預租協議單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stid_t
(
stident       number(5)      ,/* 企業編號 */
stidsite       varchar2(10)      ,/* 營運據點 */
stidunit       varchar2(10)      ,/* 應用組織 */
stiddocno       varchar2(20)      ,/* 單據編號 */
stidseq       number(10,0)      ,/* 單據項次 */
stid001       varchar2(20)      ,/* 場地編號 */
stid002       number(5,0)      ,/* 場地版本 */
stid003       varchar2(10)      ,/* 樓棟編號 */
stid004       varchar2(10)      ,/* 樓層編號 */
stid005       varchar2(10)      ,/* 區域編號 */
stid006       number(20,6)      ,/* 建築面積 */
stid007       number(20,6)      ,/* 測量面積 */
stid008       number(20,6)      ,/* 經營面積 */
stidud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stidud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stidud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stidud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stidud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stidud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stidud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stidud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stidud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stidud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stidud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stidud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stidud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stidud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stidud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stidud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stidud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stidud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stidud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stidud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stidud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stidud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stidud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stidud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stidud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stidud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stidud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stidud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stidud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stidud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stid_t add constraint stid_pk primary key (stident,stiddocno,stidseq) enable validate;

create unique index stid_pk on stid_t (stident,stiddocno,stidseq);

grant select on stid_t to tiptop;
grant update on stid_t to tiptop;
grant delete on stid_t to tiptop;
grant insert on stid_t to tiptop;

exit;
