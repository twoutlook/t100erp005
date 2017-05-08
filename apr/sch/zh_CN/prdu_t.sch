/* 
================================================================================
檔案代號:prdu_t
檔案名稱:促銷規則換贈設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdu_t
(
prduent       number(5)      ,/* 企業編號 */
prduunit       varchar2(10)      ,/* 應用組織 */
prdusite       varchar2(10)      ,/* 營運據點 */
prdu001       varchar2(20)      ,/* 規則編號 */
prdu002       number(10,0)      ,/* 換贈組別 */
prdu003       number(10,0)      ,/* 條件組別 */
prdu004       number(10,0)      ,/* 對象組別 */
prdu005       number(10,0)      ,/* 換贈數量 */
prdu006       number(20,6)      ,/* 加價金額 */
prdustus       varchar2(10)      ,/* 有效否 */
prduud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prduud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prduud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prduud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prduud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prduud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prduud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prduud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prduud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prduud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prduud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prduud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prduud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prduud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prduud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prduud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prduud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prduud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prduud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prduud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prduud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prduud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prduud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prduud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prduud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prduud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prduud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prduud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prduud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prduud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdu_t add constraint prdu_pk primary key (prduent,prdu001,prdu002,prdu003,prdu004) enable validate;

create unique index prdu_pk on prdu_t (prduent,prdu001,prdu002,prdu003,prdu004);

grant select on prdu_t to tiptop;
grant update on prdu_t to tiptop;
grant delete on prdu_t to tiptop;
grant insert on prdu_t to tiptop;

exit;
