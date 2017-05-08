/* 
================================================================================
檔案代號:glac_t
檔案名稱:會計科目資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glac_t
(
glacent       number(5)      ,/* 企業編號 */
glacownid       varchar2(20)      ,/* 資料所有者 */
glacowndp       varchar2(10)      ,/* 資料所屬部門 */
glaccrtid       varchar2(20)      ,/* 資料建立者 */
glaccrtdp       varchar2(10)      ,/* 資料建立部門 */
glaccrtdt       timestamp(0)      ,/* 資料創建日 */
glacmodid       varchar2(20)      ,/* 資料修改者 */
glacmoddt       timestamp(0)      ,/* 最近修改日 */
glacstus       varchar2(10)      ,/* 狀態碼 */
glac001       varchar2(5)      ,/* 會計科目參照表號 */
glac002       varchar2(24)      ,/* 會計科目編號 */
glac003       varchar2(1)      ,/* 統制/明細別 */
glac004       varchar2(24)      ,/* 所屬統制科目 */
glac005       number(5,0)      ,/* 科目層級 */
glac006       varchar2(1)      ,/* 科目性質 */
glac007       varchar2(1)      ,/* 科目類別 */
glac008       varchar2(1)      ,/* 正常餘額形態 */
glac009       varchar2(1)      ,/* 是否為內部管理科目 */
glac010       varchar2(1)      ,/* 費用固定變動別 */
glac011       varchar2(2)      ,/* 財務比率分析類別 */
glac012       varchar2(10)      ,/* 科目分類碼一 */
glac013       varchar2(10)      ,/* 科目分類碼二 */
glac014       varchar2(10)      ,/* 科目分類碼三 */
glac015       varchar2(10)      ,/* 科目分類碼四 */
glac016       varchar2(1)      ,/* 現金科目否 */
glac017       varchar2(1)      ,/* 啟用部門管理 */
glac018       varchar2(1)      ,/* 啟用利潤成本管理 */
glac019       varchar2(1)      ,/* 啟用區域管理 */
glac020       varchar2(1)      ,/* 啟用交易客商管理 */
glac021       varchar2(1)      ,/* 啟用客群管理 */
glac022       varchar2(1)      ,/* 啟用產品類別管理 */
glac023       varchar2(1)      ,/* 啟用人員管理 */
glac024       varchar2(1)      ,/* no use */
glac025       varchar2(1)      ,/* 啟用專案管理 */
glac026       varchar2(1)      ,/* 啟用WBS管理 */
glac027       varchar2(1)      ,/* 啟用帳款客商管理 */
glac028       varchar2(1)      ,/* 啟用經營方式管理 */
glac029       varchar2(1)      ,/* 啟用渠道管理 */
glac030       varchar2(1)      ,/* 啟用品牌管理 */
glac031       varchar2(1)      ,/* 科目做多幣別管理 */
glacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glac035       varchar2(1)      ,/* 是否是子系統科目 */
glac032       varchar2(10)      ,/* 借方現金變動碼 */
glac036       varchar2(10)      ,/* 貸方現金變動碼 */
glac041       varchar2(1)      ,/* 啟用自由核算項一 */
glac0411       varchar2(10)      ,/* 自由核算項一類型編號 */
glac0412       varchar2(1)      ,/* 自由核算項一控制方式 */
glac042       varchar2(1)      ,/* 啟用自由核算項二 */
glac0421       varchar2(10)      ,/* 自由核算項二類型編號 */
glac0422       varchar2(1)      ,/* 自由核算項二控制方式 */
glac043       varchar2(1)      ,/* 啟用自由核算項三 */
glac0431       varchar2(10)      ,/* 自由核算項三類型編號 */
glac0432       varchar2(1)      ,/* 自由核算項三控制方式 */
glac044       varchar2(1)      ,/* 啟用自由核算項四 */
glac0441       varchar2(10)      ,/* 自由核算項四類型編號 */
glac0442       varchar2(1)      ,/* 自由核算項四控制方式 */
glac045       varchar2(1)      ,/* 啟用自由核算項五 */
glac0451       varchar2(10)      ,/* 自由核算項五類型編號 */
glac0452       varchar2(1)      ,/* 自由核算項五控制方式 */
glac046       varchar2(1)      ,/* 啟用自由核算項六 */
glac0461       varchar2(10)      ,/* 自由核算項六類型編號 */
glac0462       varchar2(1)      ,/* 自由核算項六控制方式 */
glac047       varchar2(1)      ,/* 啟用自由核算項七 */
glac0471       varchar2(10)      ,/* 自由核算項七類型編號 */
glac0472       varchar2(1)      ,/* 自由核算項七控制方式 */
glac048       varchar2(1)      ,/* 啟用自由核算項八 */
glac0481       varchar2(10)      ,/* 自由核算項八類型編號 */
glac0482       varchar2(1)      ,/* 自由核算項八控制方式 */
glac049       varchar2(1)      ,/* 啟用自由核算項九 */
glac0491       varchar2(10)      ,/* 自由核算項九類型編號 */
glac0492       varchar2(1)      ,/* 自由核算項九控制方式 */
glac050       varchar2(1)      ,/* 啟用自由核算項十 */
glac0501       varchar2(10)      ,/* 自由核算項十類型編號 */
glac0502       varchar2(1)      /* 自由核算項十控制方式 */
);
alter table glac_t add constraint glac_pk primary key (glacent,glac001,glac002) enable validate;

create  index glac_01 on glac_t (glac002);
create  index glac_02 on glac_t (glac003);
create unique index glac_pk on glac_t (glacent,glac001,glac002);

grant select on glac_t to tiptop;
grant update on glac_t to tiptop;
grant delete on glac_t to tiptop;
grant insert on glac_t to tiptop;

exit;
