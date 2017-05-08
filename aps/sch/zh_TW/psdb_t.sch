/* 
================================================================================
檔案代號:psdb_t
檔案名稱:供給法則需求檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psdb_t
(
psdbent       number(5)      ,/* 企業編號 */
psdbsite       varchar2(10)      ,/* 營運據點 */
psdb001       varchar2(10)      ,/* 供給法則代號 */
psdbseq       number(10,0)      ,/* 項次 */
psdb002       varchar2(10)      ,/* 需求來源 */
psdb003       varchar2(10)      ,/* 需求檔案 */
psdb004       varchar2(10)      ,/* 欄位代號 */
psdb005       number(5,0)      ,/* 起始碼 */
psdb006       number(5,0)      ,/* 截止碼 */
psdb007       varchar2(100)      ,/* 欄位值 */
psdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psdb_t add constraint psdb_pk primary key (psdbent,psdbsite,psdb001,psdbseq) enable validate;

create unique index psdb_pk on psdb_t (psdbent,psdbsite,psdb001,psdbseq);

grant select on psdb_t to tiptop;
grant update on psdb_t to tiptop;
grant delete on psdb_t to tiptop;
grant insert on psdb_t to tiptop;

exit;
