/* 
================================================================================
檔案代號:iscd_t
檔案名稱:兼營營業人營業稅額調整表主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table iscd_t
(
iscdent       number(5)      ,/* 企業編碼 */
iscdcomp       varchar2(10)      ,/* 法人 */
iscdsite       varchar2(10)      ,/* 申報單位 */
iscd001       number(5,0)      ,/* 年度 */
iscd003       number(20,6)      ,/* 全年不得扣抵比例 */
iscd004       number(20,6)      ,/* 調整稅額 */
iscdstus       varchar2(10)      ,/* 狀態碼 */
iscdownid       varchar2(20)      ,/* 資料所有者 */
iscdowndp       varchar2(10)      ,/* 資料所屬部門 */
iscdcrtid       varchar2(20)      ,/* 資料建立者 */
iscdcrtdp       varchar2(10)      ,/* 資料建立部門 */
iscdcrtdt       timestamp(0)      ,/* 資料創建日 */
iscdmodid       varchar2(20)      ,/* 資料修改者 */
iscdmoddt       timestamp(0)      ,/* 最近修改日 */
iscdcnfid       varchar2(20)      ,/* 資料確認者 */
iscdcnfdt       timestamp(0)      ,/* 資料確認日 */
iscdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
iscdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
iscdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
iscdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
iscdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
iscdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
iscdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
iscdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
iscdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
iscdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
iscdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
iscdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
iscdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
iscdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
iscdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
iscdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
iscdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
iscdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
iscdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
iscdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
iscdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
iscdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
iscdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
iscdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
iscdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
iscdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
iscdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
iscdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
iscdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
iscdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table iscd_t add constraint iscd_pk primary key (iscdent,iscdcomp,iscdsite,iscd001) enable validate;

create unique index iscd_pk on iscd_t (iscdent,iscdcomp,iscdsite,iscd001);

grant select on iscd_t to tiptop;
grant update on iscd_t to tiptop;
grant delete on iscd_t to tiptop;
grant insert on iscd_t to tiptop;

exit;
