/* 
================================================================================
檔案代號:stad_t
檔案名稱:費用編號異動申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stad_t
(
stadent       number(5)      ,/* 企業編號 */
staddocno       varchar2(20)      ,/* 單據編號 */
stadseq       number(10,0)      ,/* 項次 */
stad001       varchar2(10)      ,/* 費用編號 */
stad002       varchar2(10)      ,/* 進出類型 */
stad003       varchar2(10)      ,/* 費用總類 */
stad004       varchar2(10)      ,/* 費用性質 */
stad005       varchar2(10)      ,/* 核算制度 */
stad006       varchar2(10)      ,/* 價款類別 */
stad007       varchar2(1)      ,/* 可票扣 */
stad008       varchar2(10)      ,/* 關聯費用編號 */
stad009       varchar2(1)      ,/* 應開發票 */
stad010       varchar2(10)      ,/* 發票稅目 */
stad011       varchar2(1)      ,/* 可帳扣 */
stadacti       varchar2(10)      ,/* 狀態碼 */
stadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stad_t add constraint stad_pk primary key (stadent,staddocno,stadseq) enable validate;

create unique index stad_pk on stad_t (stadent,staddocno,stadseq);

grant select on stad_t to tiptop;
grant update on stad_t to tiptop;
grant delete on stad_t to tiptop;
grant insert on stad_t to tiptop;

exit;
