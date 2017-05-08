/* 
================================================================================
檔案代號:isbb_t
檔案名稱:發票收款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isbb_t
(
isbbent       number(5)      ,/* 企業編碼 */
isbbcomp       varchar2(10)      ,/* 法人 */
isbbdocno       varchar2(20)      ,/* 收款單號 */
isbbseq       number(10,0)      ,/* 項次 */
isbb001       varchar2(10)      ,/* 款別 */
isbb100       varchar2(10)      ,/* 幣別 */
isbb101       number(20,10)      ,/* 匯率 */
isbb103       number(20,6)      ,/* 收款原幣金額 */
isbb104       number(20,6)      ,/* 收款本幣金額 */
isbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isbb_t add constraint isbb_pk primary key (isbbent,isbbcomp,isbbdocno,isbbseq) enable validate;

create unique index isbb_pk on isbb_t (isbbent,isbbcomp,isbbdocno,isbbseq);

grant select on isbb_t to tiptop;
grant update on isbb_t to tiptop;
grant delete on isbb_t to tiptop;
grant insert on isbb_t to tiptop;

exit;
