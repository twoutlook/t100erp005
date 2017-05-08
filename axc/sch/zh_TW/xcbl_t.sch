/* 
================================================================================
檔案代號:xcbl_t
檔案名稱:人工制費收集維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbl_t
(
xcblent       number(5)      ,/* 企業編號 */
xcblcomp       varchar2(10)      ,/* 法人組織 */
xcblld       varchar2(5)      ,/* 帳套 */
xcbl001       varchar2(10)      ,/* 費用類型 */
xcbl002       number(5,0)      ,/* 年度 */
xcbl003       number(5,0)      ,/* 期別 */
xcbl004       varchar2(10)      ,/* 成本中心 */
xcbl005       varchar2(1)      ,/* 分攤方式 */
xcblseq       number(10,0)      ,/* 項次 */
xcbl010       varchar2(24)      ,/* 科目編號 */
xcbl011       varchar2(10)      ,/* 營運組織 */
xcbl012       varchar2(10)      ,/* 部門 */
xcbl013       varchar2(10)      ,/* 收付款客商 */
xcbl014       varchar2(10)      ,/* 客群 */
xcbl015       varchar2(10)      ,/* 區域 */
xcbl016       varchar2(10)      ,/* 成本中心 */
xcbl017       varchar2(10)      ,/* 經營類別 */
xcbl018       varchar2(10)      ,/* 通路 */
xcbl019       varchar2(10)      ,/* 品類 */
xcbl020       varchar2(10)      ,/* 品牌 */
xcbl021       varchar2(20)      ,/* 專案編號 */
xcbl022       varchar2(30)      ,/* WBS */
xcbl023       varchar2(10)      ,/* 成本次要素 */
xcbl100       number(20,6)      ,/* 分攤成本 */
xcbl110       number(20,6)      ,/* 分攤成本(本位幣二) */
xcbl120       number(20,6)      ,/* 分攤成本(本位幣三) */
xcblownid       varchar2(20)      ,/* 資料所有者 */
xcblowndp       varchar2(10)      ,/* 資料所屬部門 */
xcblcrtid       varchar2(20)      ,/* 資料建立者 */
xcblcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcblcrtdt       timestamp(0)      ,/* 資料創建日 */
xcblmodid       varchar2(20)      ,/* 資料修改者 */
xcblmoddt       timestamp(0)      ,/* 最近修改日 */
xcblstus       varchar2(10)      ,/* 狀態碼 */
xcblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcblud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcbl024       varchar2(10)      ,/* 帳款對象 */
xcbl025       varchar2(20)      /* 人員 */
);
alter table xcbl_t add constraint xcbl_pk primary key (xcblent,xcblld,xcbl001,xcbl002,xcbl003,xcbl004,xcbl005,xcblseq) enable validate;

create unique index xcbl_pk on xcbl_t (xcblent,xcblld,xcbl001,xcbl002,xcbl003,xcbl004,xcbl005,xcblseq);

grant select on xcbl_t to tiptop;
grant update on xcbl_t to tiptop;
grant delete on xcbl_t to tiptop;
grant insert on xcbl_t to tiptop;

exit;
