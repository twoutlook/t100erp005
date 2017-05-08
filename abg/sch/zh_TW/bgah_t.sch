/* 
================================================================================
檔案代號:bgah_t
檔案名稱:預算組織檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgah_t
(
bgahent       number(5)      ,/* 企業編號 */
bgahownid       varchar2(20)      ,/* 資料所有者 */
bgahowndp       varchar2(10)      ,/* 資料所屬部門 */
bgahcrtid       varchar2(20)      ,/* 資料建立者 */
bgahcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgahcrtdt       timestamp(0)      ,/* 資料創建日 */
bgahmodid       varchar2(20)      ,/* 資料修改者 */
bgahmoddt       timestamp(0)      ,/* 最近修改日 */
bgahstus       varchar2(10)      ,/* 狀態碼 */
bgah001       varchar2(10)      ,/* 版本 */
bgah002       varchar2(10)      ,/* 參考法人組織 */
bgah003       varchar2(10)      ,/* 參考法人組織版本 */
bgah004       varchar2(10)      ,/* 預算組織編號 */
bgah005       varchar2(1)      ,/* 預算組織性質 */
bgah006       varchar2(1)      ,/* 使用TIPTOP */
bgah007       varchar2(10)      ,/* 營運中心代碼 */
bgah008       varchar2(10)      ,/* 所屬法人 */
bgah009       varchar2(10)      ,/* 上層預算組織 */
bgah010       varchar2(10)      ,/* 組織本位幣 */
bgahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgah_t add constraint bgah_pk primary key (bgahent,bgah001,bgah004) enable validate;

create unique index bgah_pk on bgah_t (bgahent,bgah001,bgah004);

grant select on bgah_t to tiptop;
grant update on bgah_t to tiptop;
grant delete on bgah_t to tiptop;
grant insert on bgah_t to tiptop;

exit;
